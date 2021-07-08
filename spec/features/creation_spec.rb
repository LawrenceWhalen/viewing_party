require 'rails_helper'

RSpec.describe 'User Registration form' do

    it 'is accessed through from the root' do
        visit root_path

        click_on 'Register New Account'

        expect(page).to have_current_path('/register')
        expect(page).to have_button('Register')
    end

  describe "submitting form " do
    describe "happy path" do
      it 'creates a new user' do
        visit '/register'

        email = 'test@turing.com'
        password = 'foobar'

        fill_in 'user[email]', with: email
        fill_in 'user[password]', with: password

        click_on 'Register'

        expect(page).to have_content("Welcome, #{email}!")
      end

      describe 'it makes a user in the data base' do
        it 'makes a new row in our table' do
          email = 'test@turing.com'
          password = 'foobar'

          user = User.find_by(email: email)
          expect(user).to eq(nil)

          visit '/register'

          fill_in 'user[email]', with: email
          fill_in 'user[password]', with: password

          click_on 'Register'

          new_user = User.find_by(email: email)

          expect(new_user).to_not eq(nil)
          expect(new_user.email).to eq(email)
        end

        it 'encripts password' do
          email = 'test@turing.com'
          password = 'foobar'

          user = User.find_by(email: email)
          expect(user).to eq(nil)

          visit '/register'

          fill_in 'user[email]', with: email
          fill_in 'user[password]', with: password

          click_on 'Register'

          new_user = User.find_by(email: email)

          expect(new_user.password_digest).to_not eq(password)
        end
      end

    end

    describe "sad paths" do
      it 'requires email to be filled out' do
        visit '/register'

        password = 'foobar'

        fill_in 'user[password]', with: password

        click_on 'Register'

        expect(page).to have_content("Email can't be blank")
      end

      it 'requires email to be unique ' do
        user = User.create(email: 'test@turing.com', password: 'password')

        visit '/register'

        email = 'test@turing.com'
        password = 'foobar'

        fill_in 'user[email]', with: email
        fill_in 'user[password]', with: password

        click_on 'Register'

        expect(page).to have_content("invalid email or password")
      end

      it 'requires passwords to be filled out ' do
        visit '/register'

        email = 'test@turing.com'

        fill_in 'user[email]', with: email

        click_on 'Register'

        expect(page).to have_content("Password can't be blank")
      end

      # it 'requires passwords to match  ' do
      # end
    end

  end
end
