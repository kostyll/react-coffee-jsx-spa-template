DemoApp = React.createClass
    getInitialState:->
        {
            name:@props.name
        }

    componentDidMount:->
        # alert "Mounted"
        return

    render:->
        <h1>Hello,{@state.name}!</h1>

document.onready = ->
    React.render <DemoApp name='Andrew'/>,document.getElementById 'app'
    return