class CreatePostFromFileJob
  include Sidekiq::Job

  def perform(file_content, user_id)
    parsed_content = FileParsingService.new(file_content).call

    if parsed_content
      puts '-------------- parsed content ----------------'
      puts parsed_content
      user = User.find(user_id)
      post = user.posts.create(parsed_content.except(:tags))
      post.associate_tags(parsed_content[:tags])
      puts '---------- Post criado -----------'
      puts post.inspect
    end
  end
end
