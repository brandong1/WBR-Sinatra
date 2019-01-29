
# Adds an email method to your email handlers, that receives a hash of values to create your email.

# For example:

post "/signup" do
    # sign up the user, and then email them:
    email :to      => @user.email, 
          :from    => "awesomeness@example.com", 
          :subject => "Welcome to Awesomeness!",
          :body    => haml(:some_template) #need to research haml
  end