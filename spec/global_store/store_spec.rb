require 'spec_helper'

describe GlobalStore::Store do
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

  describe ".exists?" do
    subject { GlobalStore::Store }
    it "is just an alias for .present?" do
      expect(subject.method(:exists?)).to eq(subject.method(:present?))
    end
  end

end