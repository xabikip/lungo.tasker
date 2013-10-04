class TaskCtrl extends Monocle.Controller

  elements:
    "input[name=name]"          : "name"
    "textarea[name=description]": "description"
    "select[name=list]"         : "list"
    "select[name=when]"         : "when"
    "input[name=important]"     : "important"

  events:
    "click [data-action=save]"  : "onSave"

  constructor: ->
    super
    @new = @_new
    @show = @_show
    

  # Events
  onSave: (event) ->
    if @current
      Lungo.Notification.show()
      @current.name = @name.val()
      @current.description = @description.val()
      @current.list = @list.val()
      @current.when = @when.val()
      @current.important = @important[0].checked
      @current.save()
    else
      # New task
      Lungo.Notification.show()
      __Model.Task.create
        name        : @name.val()
        description : @description.val()
        list        : @list.val()
        when        : @when.val()
        important   : @important[0].checked
      

  # Private Methods
  _new: (@current=null) ->
    @name.val ""
    @description.val ""
    @list.val ""
    @when.val ""
    @important[0].checked = false
    Lungo.Router.section "task"

  _show: (@current) ->
    @name.val @current.name
    @description.val @current.description
    @list.val @current.list
    @when.val @current.when
    @important[0].checked @current.important
    Lungo.Router.section "task"


$$ ->
  __Controller.Task = new TaskCtrl "section#task"
