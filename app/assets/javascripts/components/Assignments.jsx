var AssignmentListContainer = React.createClass({
  render: function(){
    return (
      <AssignmentList items={this.props.assignments} />
    );
  }
});

var AssignmentList = React.createClass({
  render: function(){
      var emptyMessage;
      if(this.props.items.length == 0)
        emptyMessage = <p className="grey">Doesn't look like there are any assignments yet!</p>;
      return (
        <div>
          {emptyMessage}
        </div>
      );
  }
});
