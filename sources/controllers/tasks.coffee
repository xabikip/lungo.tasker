class __Controller.TasksCtrl extends Monocle.Controller

    events:
      "click [data-action=new]"   :   "onNew"

    elements:
      "#pending"                  :   "pending"
      "#important"                :   "important"
      "input"                     :   "name"

    constructor: ->
      super
      __Model.Task.bind "create", @bindTaskCreated
      __Model.Task.bind "delete", @bindTaskDeleted
      __Model.Task.bind "change", @bindTaskChanged
      
  

    onNew: (event) ->
      __Controller.Task.new()

    bindTaskCreated: (task) =>
      context = if task.important is true then "high" else "normal"
      new __View.Task model: task, container: "article##{context} ul"
      @updateCounters()
      Lungo.Router.back()
      Lungo.Notification.hide()

    bindTaskDeleted: (task) =>
      __Model.Task.destroy()
      new __View.Task model: task

    bindTaskChanged: (task)=>
      Lungo.Router.back()
      Lungo.Notification.hide()
      @updateCounters()


    updateCounters: ->
      Lungo.Element.count "#important", __Model.Task.pendingImportant().length
      Lungo.Element.count "#pending", __Model.Task.pendingNormal().length



  
      
      
      

$$ ->
  Lungo.init({})
  Tasks = new __Controller.TasksCtrl "section#tasks"


 

