opal_filter "Singleton" do
  fails "Singleton.instance returns an instance of the singleton's clone"
  fails "Singleton.instance returns the same instance for multiple class to instance on clones"
  fails "Singleton._load returns the singleton instance for anything passed in to subclass"
  fails "Singleton._load returns the singleton instance for anything passed in"
end
