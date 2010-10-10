require 'spec_helper'

describe Comment do
  before do
    Comment.destroy_all
    @comment = Comment.new
  end

  it "should have an antispam question" do
    @comment.antispam_question.should_not be_nil
  end

  it "should have the question's hash" do
    @comment.antispam_hash.should_not be_nil
  end

  it "should fail without an answer" do
    @comment.should_not be_valid
  end

  it "should fail without a valid answer" do
    @comment.antispam_answer = 'shit'
    @comment.should_not be_valid
  end

  it "should succeed with a valid answer" do
    answer = case @comment.antispam_question
      when /sea/i then 'blue'
      when /sky/i then 'blue'
      when /france/i then 'paris'
    end
    @comment.antispam_answer = answer
    @comment.should be_valid
  end
end
