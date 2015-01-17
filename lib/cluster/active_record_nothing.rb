class ActiveRecordNothing
  include Singleton

  class << self
    def acts_as_publishables?() false end
    def acts_as_seriables?() false end
  end


  def title
    "<i class='fa fa-warning'></i> Oops".html_safe
  end

  def brief
    %q{
      <p>
        It seems that there is nothing here but the nothing. But don't worry, things will begin to fill up this place like in no time!
      </p>
    }
  end

  def content
    %q{
      <p>
        We are really sorry but the thing you tried to reach seems to be nothing else than the nothing itself. We wish we could do something about it, unfortunately, this is unlikely.
      </p>
    }
  end

  def url
    '/'
  end

end
