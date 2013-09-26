class __View.Task extends Monocle.View

  template  : """
    <li {{#done}}data-icon="check"{{/done}}>
      <div class="on-right">{{list}}<br>{{when}}</div>
      {{#done}}
      <div class="on-right button">done</div>
      {{/done}}
      <strong>{{name}}</strong>
      <small>{{description}}</small>
    </li>
  """

  constructor: ->
    super
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
    __Controller.Task.delete @model

  onView: (event) ->
    __Controller.Task.show @model
