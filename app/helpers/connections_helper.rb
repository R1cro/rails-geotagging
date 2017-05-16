module ConnectionsHelper
  def has_connected(user, object)
    @user = user
    @object = object
    @connection = Connection.where(user_id: @user.id, dynamic_object_id: @object.id)
    if @connection.length >= 1
      return true
    else
      return false
    end
  end
end
