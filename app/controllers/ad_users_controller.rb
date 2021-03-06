class AdUsersController < ApplicationController

  def index
    @headers = AdUserHeader.en_headers.filter { |k, v| AdUserHeader.default_headers.include?(k) }
    @users = AdUser.select(AdUserHeader.default_headers).limit(50)
    @users = [@users] unless @users.is_a?(ActiveRecord::Relation)
    @hidden_ad_headers = ["objectguid"]
  end

  def reload
    ldap_sync = LdapServices::LdapSync.new(LdapServices::LdapConn.new)
    ldap_sync.sync
    redirect_to(item_ad_users_path)
  end

end
