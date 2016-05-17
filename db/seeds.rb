# Todo.create!(title: 'grocery shopping', notes: 'pickles, eggs, red onion')
# Todo.create!(title: 'wash the car')
# Todo.create!(title: 'register kids for school', notes: 'Register Kira for Ruby Junior High and Caleb for Rails High School')
# Todo.create!(title: 'check engine light', notes: 'The check engine light is on in the Tacoma')
# Todo.create!(title: 'dog groomers', notes: 'Take Pinky and Redford to the groomers on Wednesday the 23rd')

user = User.new({ username: "sharky_j", avatar_url: "http://naserca.com/images/sharky_j.jpg" })
user.save

post = Post.new({ photo_url: "http://naserca.com/images/shark.jpg", user_id: user.id })
post.save

user = User.new({ username: "kirk_whalum", avatar_url: "http://naserca.com/images/kirk_whalum.jpg" })
user.save

post = Post.new({ photo_url: "http://naserca.com/images/whale.jpg", user_id: user.id })
post.save

user = User.new({ username: "marlin_peppa", avatar_url: "http://naserca.com/images/marlin_peppa.jpg" })
user.save

post = Post.new({ photo_url: "http://naserca.com/images/marlin.jpg", user_id: user.id })
post.save
