module Rails3ActsAsLicensable
  module VERSION
    def self.to_a
      [0, 0, 2, nil].compact
    end
    
    def self.to_s
      to_a.join(".")
    end
  end
end
