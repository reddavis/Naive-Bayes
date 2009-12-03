require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "NaiveBayes" do
    
  describe "Classification" do
    before do
      @classifier = NaiveBayes.new(:spam, :ham)
      @classifier.train(:spam, 'bad', 'word')
      @classifier.train(:ham, 'we', 'bad')
    end
    
    it "should classify as spam with a score of 0.5" do
      a = @classifier.classify('bad', 'word')
      a[0].should == :spam
      a[1].should == 0.5
    end
  end
  
end
