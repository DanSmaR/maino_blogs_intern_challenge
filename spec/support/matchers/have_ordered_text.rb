RSpec::Matchers.define :have_ordered_text do |*expected_texts|
  match do |page|
    expected_texts.flatten.map(&:to_s).each_cons(2).all? do |a, b|
      page.body.index(a) < page.body.index(b)
    end
  end

  failure_message do |page|
    "expected that #{page.body} would have the texts in the correct order"
  end

  failure_message_when_negated do |page|
    "expected that #{page.body} would not have the texts in the correct order"
  end
end