var Exchanges = React.createClass({
  getInitialState: function() {
    return {
      exchanges: this.props.exchanges
    }
  },
  getDefaultProps: function() {
    exchanges: []
  },
   componentDidMount: function() {
  },
  render: function() {
    var exchanges = this.state.exchanges.map((exchange) => { 
      return ( 
        <tr> 
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
                <i className='fa fa-refresh'></i>
              </div>
            </h3>
          </div>
        </div>
        <div className='row'>
          <div className='col-md-12'>
            <table>
              <tr>
                <th>ID</th>
                <th>Trading date</th>
                <th>Effective date</th>
                <th></th>
              </tr>
              {exchanges}
            </table>
          </div>
        </div>
      </div>
    );
  }
});
