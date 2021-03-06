var AssignmentTypesContainer = React.createClass({
  getInitialState: function(){
    return {
      types: this.props.current_types,
      error: ""
    };
  },
  setError: function(message){
    this.setState({error: message});
  },
  processTypes: function(data){
    this.setState({types: data});
  },
  refreshTypes: function(){
    // TODO: experiment with tick realtime
    $.getJSON(window.location, this.processTypes);
  },
  deleteType: function(id){
    var ast = this;
    $.ajax(
      { type: "DELETE", url: window.location + '/' + id,
        success: function(res){
          if(res == -1){
            ast.setError("You can't delete an assignment type if there are existing assignments of that type.");
          }else if(res == -2){
            ast.setError("You can't delete this assignment type - each course must have at least one assignment type.")
          }else{
            var new_types = ast.state.types.filter(function(item) {
              return item.id !== id;
            });
            ast.setState({types: new_types});
          }
        }
      });
    },
  updateType: function(typeObject){
    var name = typeObject.state.name;
    var id = typeObject.state.id;
    var drops_lowest = typeObject.state.drops_lowest;
    var default_point_value = typeObject.state.default_point_value;

    if(typeof typeObject.state.temp_id === "undefined"){

      // updating an existing type

      $.ajax({ type: "PUT", url: window.location + '/' + id, data: {
          name: name,
          drops_lowest: drops_lowest,
          default_point_value: default_point_value
        }
      });

    }else{

      // creating a new type

      $.ajax({ type: "POST", url: window.location, data: {
          name: name,
          drops_lowest: drops_lowest,
          default_point_value: default_point_value
        }
      });

    }
    this.refreshTypes();
  },
  newType: function(){
    this.setError("");
    var current_types = this.state.types;
    var temp_id = Math.floor((Math.random() * 999999) + 1);
    current_types.push({
           temp_id: temp_id,
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
      return item.temp_id !== cancelingType.state.temp_id;
    });
    this.setState({types: new_types});
  },
  render: function() {
    return (
      <div>
        <ErrorBox message={this.state.error} />
        <AssignmentTypesList
          types={this.state.types}
          newType={this.newType}
          deleteType={this.deleteType}
          updateType={this.updateType}
          errorHandler={this.setError}/>
      </div>
    );
  }

});

var AssignmentTypesList = React.createClass({
  render: function() {

      var errorHandler = this.props.errorHandler;
      var deleteType = this.props.deleteType;
      var updateType = this.props.updateType;

      var createTypeItem = function(typeObject) {
        var keyValue = (typeObject.hasOwnProperty("id")) ? typeObject.id : typeObject.temp_id;
        return <AssignmentTypeItem
          typeObject={typeObject}
          key={keyValue}
          errorHandler={errorHandler}
          deleteType={deleteType}
          updateType={updateType}
          />;
      };

      var emptyMessage = "";
      if(this.props.types.length == 0){
        emptyMessage = (
          <tr><td colSpan="4" className="empty-row">No assignment types yet!</td></tr>
        );
      }

      return (
        <div>
          <table className='assignmentTypeList'>
            <th width='30%'>Name</th>
            <th width='25%'>Drops Lowest Score</th>
            <th width="20%">Default Point Value (optional)</th>
            <th width="25%">Manage</th>
            <tbody>
              {this.props.types.map(createTypeItem)}
              {emptyMessage}
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
      temp_id: to.temp_id,
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

    // Either we just hit the cancel button,
    // or we want to save this type

    if(!this.state.editing){
        this.setState({initialState: this.state});
    }else{
      console.log("Saving type...");
      var name = this.refs.name.getDOMNode().value;
      var dpv = this.refs.dpv.getDOMNode().value;
      if(!name){
        this.props.errorHandler("Name can't be blank!");
        return;
      }else{
        this.props.errorHandler("");
        // send to db
        this.props.updateType(this);
      }
    }

    this.setState({editing: !this.state.editing});

  },
  deletePressed: function(){
    var confirm = window.confirm("Are you sure you want to delete this?");
    if(confirm)
      this.props.deleteType(this.state.id);
  },
  cancelPressed: function(){
    // reset properties
    // if we don't have an initial state,
    // we're canceling creating a new one
    this.props.errorHandler("");
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
              <button className='small secondary' onClick={this.editPressed}>Edit</button>
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
