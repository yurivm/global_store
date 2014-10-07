require 'spec_helper'

describe GlobalStore::Store do
  before(:each) do
    GlobalStore.configure do |config|
      config.storage = RequestStore
    end
  end
  after(:each) do
    GlobalStore.reset_configuration!
  end
  describe ".key_prefix" do
    subject { GlobalStore::Store }
    it "uses the key_prefix provided by the configuration that defaults to global_store" do
      subject.set(:some_key, "value")
      expect(subject.exists?(:global_store_some_key)).to eq(true)
    end
    it "uses a custom key prefix if specified" do
      GlobalStore.configure { |config| config.key_prefix = :oh_noes}
      subject.set(:some_key, "value")
      expect(subject.exists?(:oh_noes_some_key)).to eq(true)
    end
  end

  describe ".storage" do
    subject { GlobalStore::Store} 
    it "uses the storage provided" do
      GlobalStore.configure{ |config| config.storage = Thread.current }
      subject.set(:some_key, "value")
      expect(Thread.current.key?(:global_store_some_key)).to eq(true)
    end
  end

  describe ".get" do
    subject { GlobalStore::Store }
    it "returns the value if it had been previously set" do
      subject.set('key', {val: :ue})
      expect(subject.get('key')).to eq({val: :ue})
    end
    it "is threadsafe" do
      subject.set('wat', ['is', 'dat'])
      Thread.new { expect(GlobalStore::Store.get('wat')).to be_nil }.join
    end
    it "returns nil if the key is not set" do
      expect(subject.get('albatross')).to be_nil
    end
    it "is aliased as []" do
      subject.set('wat', ['is', 'dat'])
      expect(subject['wat']).to eq(['is', 'dat'])
    end
  end

  describe ".set" do
    subject { GlobalStore::Store }
    it "sets the value of the associated key" do
      subject.set('albatross_flavour', 'seagull')
      expect(subject.get('albatross_flavour')).to eq('seagull')
    end
    it "is threadsafe" do
      subject.set('albatross_flavour', 'seagull')
      Thread.new { subject.set('albatross_flavour', -42) }.join
      expect(subject.get('albatross_flavour')).to eq('seagull')
    end
    it "returns the value it sets" do
      expect(subject.set('alert', 'ERR_OUT_OF_COFFEE')).to eq('ERR_OUT_OF_COFFEE')
    end
    it "is aliased as []=" do
      subject['albatross_flavour'] = 'seagull'
      expect(subject.get('albatross_flavour')).to eq('seagull')
    end
  end

  describe ".present?" do
    subject { GlobalStore::Store }
    it "returns true if the value specified by the key is present (not blank)" do
      subject.set(:parrot, :is_no_more)
      expect(subject.present?(:parrot)).to eq(true)
    end
    it "returns false otherwise" do
      expect(subject.present?(:whats_your_status)).to eq(false)
    end
  end


  describe ".blank?" do
    subject { GlobalStore::Store }
    it "returns true if the value specified by the key is blank (not present)" do
      expect(subject.blank?(:whats_your_status)).to eq(true)
    end
    it "returns false otherwise" do
      subject.set(:parrot, :is_no_more)
      expect(subject.blank?(:parrot)).to eq(false)
    end
  end

  describe ".exists?" do
    subject { GlobalStore::Store }
    it "returns true if the specified key exists (i.e. has been set)" do
      subject.set(:lunchtime, nil)
      expect(subject.exists?(:lunchtime)).to eq(false)
    end
  end

  describe ".exist?" do
    subject { GlobalStore::Store }
    it "is just an alias for .exists?" do
      expect(subject.method(:exist?)).to eq(subject.method(:exists?))
    end
  end

end