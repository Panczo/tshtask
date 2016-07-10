var Exchanges = React.createClass({
  getInitialState: function() {
    return {
      exchanges: this.props.exchanges,
      refresh_path: this.props.refresh_path,
      current_page: 0,
      exchanges_range: 0
    }
  },
  getDefaultProps: function() {
    return {
      exchanges: [],
      current_page: 0,
      exchanges_range: 0
    }
  },
  componentDidMount: function() {
    var ex = _.chunk(this.state.exchanges, 8);
    this.setState({exchanges_range: ex.length});
  },
  handleRefresh: function() {
    $.ajax({ 
      url: this.state.refresh_path, 
      type: 'GET', 
      datatype: 'json',
      success: function(exchange) {
        var nowe_ex = _.concat(exchange, this.state.exchanges);
        this.setState({ exchanges: nowe_ex });
        toastr.success('List was successfully refreshed', 'Success');
      }.bind(this),
      error: function(xhr) {
        var errormsg = $.parseJSON(xhr.responseText).errors
        toastr.error(errormsg);
      },
/*      beforeSend: function() { 
        that.setState({load: !that.state.load}) 
      },
      complete: function() {
        that.setState({load: !that.state.load})
      }*/
    });
  },
  renderAnglePrevious: function() {
    if ( this.state.current_page != 0 ) {
        return <i className="fa fa-angle-left" onClick={this.handlePreviousExchanges}></i>;
    }
  },
  renderAngleNext: function() {
    if ( (this.state.current_page + 1) < this.state.exchanges_range ) {
        return <i className="fa fa-angle-right" onClick={this.handleNextExchanges}></i>;
    }
  },
  handleNextExchanges: function() {
    console.log("Next exchanges");
    this.setState({current_page: this.state.current_page + 1})
  },
  handlePreviousExchanges: function() {
    console.log("Previous exchanges");
    this.setState({current_page: this.state.current_page - 1})
  },
  render: function() {
    var ex = _.chunk(this.state.exchanges, 8);
    var exchanges = ex[this.state.current_page].map((exchange) => { 
      return ( 
        <tr key={exchange.id}> 
          <td>{exchange.name}</td> 
          <td>{exchange.trading_date}</td> 
          <td>{exchange.effective_date}</td> 
          <td className='pull-right'>
            <a href={'money/' + exchange.id} className='btn btn-exchange'>VIEW</a>
          </td> 
        </tr> 
      ) 
    });
    return (
      <div className='container exchanges'>
        <div className='row'>
          <div className='col-md-12'>
            <h3 className='page-header'>
              <div className='pull-left'>All exchanges</div>
              <div className='pull-right'>
                <button className="btn btn-refresh" onClick={this.handleRefresh}><i className='fa fa-refresh'></i></button>
              </div>
            </h3>
          </div>
        </div>
        <div className='row'>
          <div className='col-md-12'>
            <table>
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Trading date</th>
                  <th>Effective date</th>
                  <th></th>
                </tr>
              </thead>
              <tbody>
                {exchanges}
              </tbody>
            </table>
          </div>
          <div className='col-md-12 text-center pagination'>
            {this.renderAnglePrevious()}
            {this.renderAngleNext()}
          </div>
        </div>
      </div>
    );
  }
});
