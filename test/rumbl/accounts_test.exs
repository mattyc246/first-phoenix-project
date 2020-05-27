defmodule Rumbl.AccountsTest do
  use Rumbl.DataCase, async: true

  alias Rumbl.Accounts
  alias Rumbl.Accounts.User

  describe "register_user/1" do
    @valid_attrs %{
      name: "User",
      username: "eva",
      email: "eva@email.com",
      password: "secretpassword"
    }
    @invalid_attrs %{}

    test "with valid data inserts user" do
      assert {:ok, %User{id: id} = user} = Accounts.register_user(@valid_attrs)
      assert user.name == "User"
      assert user.username == "eva"
      assert user.email == "eva@email.com"
      assert [%User{id: ^id}] = Accounts.list_users()
    end

    test "with invalid data does not insert user" do
      assert {:error, _changeset} = Accounts.register_user(@invalid_attrs)
      assert Accounts.list_users() == []
    end

    test "enforces unique usernames" do
      assert {:ok, %User{id: id} = user} = Accounts.register_user(@valid_attrs)
      assert {:error, changeset} = Accounts.register_user(@valid_attrs)
      assert %{username: ["has already been taken"]} = errors_on(changeset)
      assert [%User{id: ^id}] = Accounts.list_users()
    end

    test "requires password to be at least 8 chars long" do
      attrs = Map.put(@valid_attrs, :password, "123456")
      {:error, changeset} = Accounts.register_user(attrs)
      assert %{password: ["should be at least 8 character(s)"]} = errors_on(changeset)
      assert Accounts.list_users() == []
    end
  end

  describe "authenticate_by_email_and_pass/2" do
    @pass "secretpassword"

    setup do
      {:ok, user: user_fixture(password: @pass)}
    end

    test "return user with correct password", %{user: user} do
      assert {:ok, auth_user} = Accounts.authenticate_by_email_and_password(user.email, @pass)
      assert auth_user.id == user.id
    end

    test "return unauthorized error with incorrect password", %{user: user} do
      assert {:error, :unauthorized} = Accounts.authenticate_by_email_and_password(user.email, "badpass")
    end

    test "return not found error for with no matching user by email" do
      assert {:error, :not_found} = Accounts.authenticate_by_email_and_password("anyemail@mail.com", @pass)
    end
  end

end