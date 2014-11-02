var AssignmentTypesContainer = React.createClass({
  getInitialState: function(){
    return {
      types: this.props.current_types
    };
  },
  processTypes: function(data){
    this.setState({types: data});
  },
  tick: function(){
    $.getJSON(window.location, this.processTypes);
  },
  newType: function(){
    var current_types = this.state.types;
    var temp_id = Math.floor((Math.random() * 999999) + 1);
    current_types.push({
           id: temp_id,
           name: "",
           default_point_value: 100,
           drops_lowest: false,
           percentage: 20,
           editing: true,
           cancel_function: this.cancelNewType
        });
    this.setState({types: current_types});
  },
  cancelNewType: function(cancelingType){
    var new_types = this.state.types.filter(function(item) {
      return item.id !== cancelingType.state.id;
    });
    this.setState({types: new_types});
  },
  render: function() {
    return <AssignmentTypesList types={this.state.types} newType={this.newType} />
  }

});

var AssignmentTypesList = React.createClass({
  render: function() {

      var createTypeItem = function(typeObject) {
        return <AssignmentTypeItem
          typeObject={typeObject}
          key={typeObject.id}
          />;
      };
      return (
        <div>
          <table className='assignmentTypeList'>
            <th width='30%'>Name</th>
            <th width='25%'>Drops Lowest Score</th>
            <th width="20%">Default Point Value (optional)</th>
            <th width="25%">Manage</th>
            <tbody>
              {this.props.types.map(createTypeItem)}
            </tbody>
          </table>
          <button className='small' onClick={this.props.newType}>+ New Assignment Type</button>
        </div>
      );
  }
});

var AssignmentTypeItem = React.createClass({
  getInitialState: function(){
    var to = this.props.typeObject;
    return {
      id: to.id,
      editing: (to.hasOwnProperty("editing")) ? to.editing : false,
      name: to.name,
      drops_lowest: to.drops_lowest,
      default_point_value: to.default_point_value,
      cancel_function: (to.hasOwnProperty("cancel_function")) ? to.cancel_function : function(){}
    };
  },
  dropsLowest: function(){
    return (this.state.drops_lowest) ? "Yes" : "No";
  },
  editPressed: function(){

    if(!this.state.editing){
        this.setState({initialState: this.state});
    }else{
      console.log("Saving type...");
      var name = this.refs.name.getDOMNode().value;
      var dpv = this.refs.dpv.getDOMNode().value;
      if(!name || !dpv)
        return;
    }

    this.setState({editing: !this.state.editing});

  },
  deletePressed: function(){

  },
  cancelPressed: function(){
    // reset properties
    // if we don't have an initial state,
    // we're canceling creating a new one
    if(this.state.hasOwnProperty("initialState")){
        var to = this.state.initialState;
        this.setState({
          id: to.id,
          editing: false,
          name: to.name,
          drops_lowest: to.drops_lowest,
          default_point_value: to.default_point_value
        });
    }else{
      this.state.cancel_function(this);
    }
  },
  changeName: function(event){
    this.setState({name: event.target.value});
  },
  changeDefaultPointValue: function(event){
    this.setState({default_point_value: event.target.value});
  },
  switchDropped: function(){
    this.setState({drops_lowest: !this.state.drops_lowest});
  },
  render: function(){
    if(!this.state.editing){
        return (
          <tr>
            <td>{this.state.name}</td>
            <td>{this.dropsLowest()}</td>
            <td>{this.state.default_point_value}</td>
            <td>
              <button className='small primary' onClick={this.editPressed}>Edit</button>
              <button className='small alert' onClick={this.deletePressed}>Delete</button>
            </td>
          </tr>
        );
    }else{
      return (
        <tr className='editing'>
          <td><input type="text" ref="name" value={this.state.name} onChange={this.changeName}/></td>
          <td><BooleanPicker bool={this.state.drops_lowest} onChange={this.switchDropped} /></td>
          <td><input type="text" ref="dpv" value={this.state.default_point_value} onChange={this.changeDefaultPointValue}/></td>
          <td>
            <button className='small' onClick={this.editPressed}>Done</button>
            <button className='small secondary' onClick={this.cancelPressed}>Cancel</button>
          </td>
        </tr>
      );
    }
  }
});
