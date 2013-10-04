class __View.Task extends Monocle.View

  template  : """
    <li id={{uid}}>
      {{#done}}<span class="icon check"></span>{{/done}}
      {{^done}}<span class="icon check-empty"></span>{{/done}}
      <div class="on-right">{{list}}<br>{{when}}</div>
      <strong>{{name}}</strong>
      <small>{{description}}</small>
    </li>
  """

  constructor: ->
    super
    __Model.Task.bind "update", @bindTaskUpdated
    @append @model

  events:
    "swipeLeft li"  :  "onDelete"
    "hold li"       :  "onDone"
    "singleTap li"  :  "onView"

  elements:
    "input.toggle"  : "toggle"

  onDone: (event) =>
      @model.updateAttributes done: true
      @refresh()
    
  onDelete: (event) ->
    Lungo.Notification.confirm
      icon: "question-sign",
      title: "Confirm delete"
      description: "Are you sure to delete task?"
      accept:
        icon: "ok"
        label: "accept"
        callback: =>
          @remove()
          @model.destroy()
      cancel:
        icon: "remove"
        label: "Cancel"
        callback: =>
          @


  onView: (event) ->
    __Controller.Task.show @model

  bindTaskUpdated: (task) =>
    if task.uid is @model.uid
      @model = task
      @refresh()
    Lungo.Notification.hide()
    Lungo.Router.back()
