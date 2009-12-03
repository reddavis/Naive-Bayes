require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "NaiveBayes" do
    
  describe "Classification" do
    before do
      @classifier = create_and_train_classifier
    end
    
    it "should classify as spam with a score of 0.5" do
      a = @classifier.classify('bad', 'word')
      a[0].should == :spam
      a[1].should == 0.5
    end
  end
  
  describe "Save" do
    before do
      @classifier = NaiveBayes.new(:spam, :ham)
      @classifier.db_filepath = db_filepath
    end
    
    it "should save to the filepath provided" do
      FileUtils.rm(db_filepath, :force => true)
      @classifier.train(:spam, 'bad')
      File.exists?(db_filepath).should be_true
    end
  end
  
  describe "Load" do
    before do
      classifier = NaiveBayes.new(:spam, :ham)
      classifier.db_filepath = db_filepath
      classifier.train(:spam, 'bad', 'word')
      classifier.train(:ham, 'we', 'bad')
    end
    
    it "should return 0.5" do
      classifier = NaiveBayes.load(db_filepath)
      classifier.classify('bad', 'word')[1].should == 0.5
    end
  end
  
  private
  
  def create_and_train_classifier
    a = NaiveBayes.new(:spam, :ham)
    a.train(:spam, 'bad', 'word')
    a.train(:ham, 'we', 'bad')
    a
  end
  
  def db_filepath
    File.expand_path(File.dirname(__FILE__) + '/db/naive.nb')
  end
  
end
