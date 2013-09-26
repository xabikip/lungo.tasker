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
      __Model.Task.updateAttributes
        

    else
      # New task
      Lungo.Notification.show()
      __Model.Task.create
        name        : @name.val()
        description : @description.val()
        list        : @list.val()
        when        : @when.val()
        important   : @important[0].checked


  delete: (event) ->
      __Model.Task.delete @model
      console.log (event)
      
      

  # Private Methods
  _new: (@current=null) ->
    @name.val ""
    @description.val ""
    Lungo.Router.section "task"

  _show: (@current) ->
    @name.val @current.name
    @description.val @current.description
    Lungo.Router.section "task"

$$ ->
  __Controller.Task = new TaskCtrl "section#task"
