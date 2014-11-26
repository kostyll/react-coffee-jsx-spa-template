DemoApp = React.createClass
    getInitialState:->
        {
            name:@props.name
        }

    componentDidMount:->
        # alert "Mounted"
        return

    testClick:->
        alert "Clicked!"

    render:->
        <div>
            <h1>Hello,{@state.name}!</h1>
            <Button bsStyle="primary" onClick={@testClick}>Test click</Button>
        </div>

Button = ReactBootstrap.Button

document.onready = ->
    React.render <DemoApp name='Andrew'/>,document.getElementById 'app'
    return