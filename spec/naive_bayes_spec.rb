require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "NaiveBayes" do
  
  describe "Initialization" do
    before(:all) do
      @classifier = NaiveBayes.new(:spam, :ham)
    end
    
    it "should create a features count for each class" do
      @classifier.features_count.size.should == 2
    end
  end
  
  describe "Training" do
    before(:all) do
      @classifier = NaiveBayes.new(:spam, :ham)
      @classifier.train(:spam, 'bad', 'word')
    end
        
    it "should train" do
      @classifier.features_count[:spam].size.should == 2
    end
    
    it "should bump klass_count for spam up to 1" do
      @classifier.klass_count[:spam].should == 1
    end
  end
  
  describe "Classification" do
    before do
      @classifier = NaiveBayes.new(:spam, :ham)
      @classifier.train(:spam, 'bad', 'word')
      @classifier.train(:ham, 'we', 'bad')
    end
    
    it "should" do
      a = @classifier.classify('bad', 'word')
      a[0].should == :spam
      a[1].should == 0.5
    end
  end
  
end
