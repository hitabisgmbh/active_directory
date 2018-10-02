= Active Directory

Based on https://github.com/KMakowsky/active_directory

Extends the existing Gem by a non-global Connection Management.

All functions are the same, but handled a little bit different.

There are no static objects like:
ActiveDirectory::Base
ActiveDirectory::Users
ActiveDirectory::Group
ActiveDirectory::Computers

You need to create instances from them:
<pre>
base = ActiveDirectory::Base.new # equivalent of ActiveDirectory::Base
base.as_user # equivalent of ActiveDirectory::User
base.as_group # equivalent of ActiveDirectory::Group
base.as_computer # equivalent of ActiveDirectory::Computer
</pre>

See documentation on ActiveDirectory::Base for more information.
https://www.rubydoc.info/gems/active_directory/1.6.1.1

Caching:
Queries for membership and group membership are based on the distinguished name of objects.  Doing a lot of queries, especially for a Rails app, is a sizable slowdown.  To alleviate the problem, I've implemented a very basic cache for queries which search by :distinguishedname.  This is disabled by default.  All other queries are unaffected.


A code example is worth a thousand words:

<pre>
require 'rubygems'
require 'active_directory'

# Uses the same settings as net/ldap
settings = {
	:host => 'domain-controller.example.local',
	:base => 'dc=example,dc=local',
	:port => 636,
	:encryption => :simple_tls,
	:auth => {
	  :method => :simple,
	  :username => "username",
	  :password => "password"
	}
}

# Basic usage
base = ActiveDirectory::Base.new
base.setup(settings)

base.connected? # returns true on login success

base.as_user.find(:all)
base.as_user.find(:first, :userprincipalname => "john.smith@domain.com")

base.as_group.find(:all)

#Caching is disabled by default, to enable:
base.enable_cache
base.disable_cache
base.cache?

</pre>
