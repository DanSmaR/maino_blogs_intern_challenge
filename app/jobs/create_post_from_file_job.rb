class CreatePostFromFileJob
  include Sidekiq::Job

  def perform(file_path, user_id)
    begin
      file = File.open(file_path)
      parsed_content = FileParsingService.new(file).call

      if parsed_content
        puts '-------------- parsed content ----------------'
        puts parsed_content
        user = User.find(user_id)
        post = user.posts.create(parsed_content.except(:tags))
        post.associate_tags(parsed_content[:tags])
        puts '---------- Post criado -----------'
        puts post.inspect
      end
    ensure
      File.delete(file_path) if File.exist?(file_path)
    end
  end
end
