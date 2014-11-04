/*
  A boolean picker button.
  Takes an initial value and an onChange() function
*/

var BooleanPicker = React.createClass({
  getInitialState: function(){
    return {
      bool: this.props.bool
    };
  },
  switchValue: function(){
    this.setState({bool: !this.state.bool});
    this.props.onChange();
  },
  render: function(){
    var buttonText = (this.state.bool) ? "Yes ✓" : "No ✗";
    return (
      <span>
        <button className='small secondary' onClick={this.switchValue}>{buttonText}</button>
      </span>
    );
  }
});

/*
  An error box. Hides if there is no error message.
*/

var ErrorBox = React.createClass({
  render: function(){
    var classes = 'panel error radius ';
    classes += (this.props.message == "") ? 'hidden' : '';
    return (
      <div className={classes}>{this.props.message}</div>
    );
  }
});
