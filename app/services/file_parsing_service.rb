class FileParsingService
  def initialize(uploaded_file)
    @uploaded_file = uploaded_file
  end

  def call
    return false unless @uploaded_file.present?

    file_content = File.open(@uploaded_file, "r:UTF-8").read
    lines = file_content.split("\n")

    title = lines[0]
    content = lines[1..-2].join("\n")

    return false unless title.present? && content.present?

    { title: title, content: content, tags: lines.last }
  end
end
