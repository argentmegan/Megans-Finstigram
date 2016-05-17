helpers do
    def current_user
        User.find_by(id: session[:user_id])
    end
end

def humanized_time_ago(time_ago_in_minutes)
    if time_ago_in_minutes >= 60
        "#{time_ago_in_minutes / 60} hours ago"
    else
        "#{time_ago_in_minutes} minutes ago"
    end
end

get '/' do
   @posts = Post.order(created_at: :desc)
   erb(:index)
end

get '/signup' do   # if a user navigates to the path "/signup"
    @user = User.new  # setup empty @user object
    erb(:signup)  # render "app/views/signup.erb"
end

post '/signup' do  
    # grab user input values from params
    email = params[:email]
    avatar_url = params[:avatar_url]
    username = params[:username]
    password = params[:password]

    # instantiate and save a User
    @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password })
    
    # if user validation pass and user is saved
 if @user.save
    redirect(to('/login'))
 else
    erb(:signup)
 end
end

get '/login' do # when a GET requests into /login
    erb(:login) # render app/views/login.erb
end

post '/login' do
    username = params[:username]
    password = params[:password]
    
    # 1. find user by username
    user = User.find_by(username: username)
        
        # check if that user's passwork matches the password input
        # 3. if the password match
        if user && user.password == password
            session[:user_id] = user.id
            redirect(to('/'))
        else
            @error_message = "Login failed."
            erb(:login)
        end
end

get '/logout' do
    session[:user_id] = nil
    redirect(to('/'))
end

get '/posts/new' do 
    erb(:"posts/new")
end

post '/posts' do
    photo_url = params[:photo_url]
    
    #instantiate new Post
    @post = Post.new({ photo_url: photo_url })
    
    # if @post validates, save
    if @post.save
        redirect(to('/'))
    else
        
        #if it doesn't validate, print error messages
        @post.errors.full_messages.inpsect
    end
end

post '/comments' do
    # point values from params to varibles
    text = params[:text]
    post_id = params[:post_id]

    # instantiate a comment with those values & assign the comment to the 'current_user'
    comment = Comment.new({ text: text, post_id: post_id, user_id: current_user.id})

    # save the comment
    comment.save
    
    # 'redirect' back to wherever we came from
    redirect'/'
end


get '/posts/:id' do
    @post = Post.find(params[:id])      #find the post with the ID from the URL
    erb(:"posts/show")                  #render app/views/posts/show.erb
end

post '/likes' do
    post_id = paramas[:post_id]
    
    like = Like.new({ post_id: post_id, user_id: current_user.id})
    like.save
    
    redirect'/'
end

delete '/likes/:id' do
    like = Like.find(params[:id])
    like.destroy
    redirect'/'
end