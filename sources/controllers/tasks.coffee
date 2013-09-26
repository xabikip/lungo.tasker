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
      Lungo.Router.back()
      Lungo.Notification.hide()

    bindTaskDeleted: (task) =>
      __Model.Task.destroy()
      new __View.Task model: task

    
    bindTaskChanged: (task) =>
      
      

$$ ->
  Lungo.init({})
  Tasks = new __Controller.TasksCtrl "section#tasks"


  __Model.Task.create name:"tarea uno name", description: "descripcion de la tarea 1", list: "home", when: "10/08/2013"
  __Model.Task.create name:"comer y correr", description: "descripcion de la tarea 2", list: "office", when: "10/21/2013"
  __Model.Task.create name:"limpiar casa", description: "descripcion de la tarea", list: "home", when: "10/21/2013"


