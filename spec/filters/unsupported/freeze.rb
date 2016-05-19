opal_filter "freezing" do
  fails "Array#delete returns nil on a frozen array if a modification does not take place"
  fails "Array#dup does not copy frozen status from the original"
  fails "Array#rotate does not mutate the receiver"
  fails "Array#rotate! raises a RuntimeError on a frozen array"
  fails "Array#select! on frozen objects returns an Enumerator if no block is given"
  fails "Array#sort does not freezes self during being sorted"
  fails "Array#sort_by! raises a RuntimeError on a frozen array"
  fails "Array#sort_by! raises a RuntimeError on an empty frozen array"
  fails "Date constants freezes MONTHNAMES, DAYNAMES, ABBR_MONTHNAMES, ABBR_DAYSNAMES"
  fails "Enumerable#sort doesn't raise an error if #to_a returns a frozen Array"
  fails "Hash#== compares keys with matching hash codes via eql?"
  fails "Hash#[]= doesn't duplicate and freeze already frozen string keys"
  fails "Hash#delete_if returns an Enumerator if called on a frozen instance"
  fails "Hash#each returns an Enumerator if called on a frozen instance"
  fails "Hash#each_key returns an Enumerator if called on a frozen instance"
  fails "Hash#each_pair returns an Enumerator if called on a frozen instance"
  fails "Hash#each_value returns an Enumerator if called on a frozen instance"
  fails "Hash#eql? compares keys with matching hash codes via eql?"
  fails "Hash#keep_if returns an Enumerator if called on a frozen instance"
  fails "Hash#reject returns an Enumerator if called on a frozen instance"
  fails "Hash#select returns an Enumerator if called on a frozen instance"
  fails "Hash#select! returns an Enumerator if called on a frozen instance"
  fails "Hash#store doesn't duplicate and freeze already frozen string keys"
  fails "Kernel#clone copies frozen state from the original"
  fails "Kernel#freeze on a Symbol has no effect since it is already frozen"
  fails "Kernel#freeze prevents self from being further modified"
  fails "Kernel#freeze returns self"
  fails "Kernel#frozen? on a Symbol returns true"
  fails "Kernel#frozen? returns true if self is frozen"
  fails "MatchData#string returns a frozen copy of the match string"
  fails "Module#alias_method raises RuntimeError if frozen"
  fails "Module#append_features when other is frozen raises a RuntimeError before appending self"
  fails "Module#const_set on a frozen module raises a RuntimeError before setting the name"
  fails "Module#extend_object when given a frozen object raises a RuntimeError before extending the object"
  fails "Module#remove_method on frozen instance does not raise exceptions when no arguments given"
  fails "Module#remove_method on frozen instance raises a RuntimeError when passed a missing name"
  fails "Module#remove_method on frozen instance raises a RuntimeError when passed a name"
  fails "Module#remove_method on frozen instance raises a TypeError when passed a not name"
  fails "Module#undef_method on frozen instance does not raise exceptions when no arguments given"
  fails "Module#undef_method on frozen instance raises a RuntimeError when passed a missing name"
  fails "Module#undef_method on frozen instance raises a RuntimeError when passed a name"
  fails "Module#undef_method on frozen instance raises a TypeError when passed a not name"
  fails "OpenStruct#method_missing when called with a method name ending in '=' raises a TypeError when self is frozen"
  fails "String#clone copies frozen state"
  fails "String#initialize with no arguments does not raise an exception when frozen"
  fails "StringScanner#initialize returns an instance of StringScanner"
  fails "A singleton method definition raises RuntimeError if frozen"
  fails "A method definition inside a metaclass scope raises RuntimeError if frozen"
  fails "Hash literal does not change encoding of literal string keys during creation"
  fails "Hash literal freezes string keys on initialization"
end