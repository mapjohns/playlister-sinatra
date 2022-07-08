module Slugifiable
    module InstanceMethods
        def slug
            self.name.downcase.split(" ").join("-")
        end

    end
  
    module ClassMethods
  
      def find_by_slug(slug)
        self.all.each do |x|
            if x.slug == slug
                return x
            end
        end
      end

    end
  end

  