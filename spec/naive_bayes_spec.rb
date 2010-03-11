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
  
  describe "Saving the NB" do
    describe "DB filepath has been set" do
      before do
        @classifier = NaiveBayes.new(:spam, :ham)
        @classifier.db_filepath = db_filepath
      end
    
      it "should save to the filepath provided" do
        FileUtils.rm(db_filepath, :force => true)
        @classifier.save
        File.exists?(db_filepath).should be_true
      end
    end
    
    describe "DB filepath has no been set" do
      it "should raise an error" do
        lambda do  
          NaiveBayes.new(:spam, :ham).save
        end.should raise_error
      end
    end
  end
  
  describe "Load" do
    before do
      classifier = NaiveBayes.new(:spam, :ham)
      classifier.db_filepath = db_filepath
      classifier.train(:spam, 'bad', 'word')
      classifier.train(:ham, 'we', 'bad')
      classifier.save
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
