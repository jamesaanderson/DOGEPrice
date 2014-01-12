class AppDelegate
  INTERVAL = 30

  attr_accessor :status_menu

  def applicationDidFinishLaunching(notification)
    @app_name = NSBundle.mainBundle.infoDictionary['CFBundleDisplayName']

    @status_menu = NSMenu.new

    @status_item = NSStatusBar.systemStatusBar.statusItemWithLength(NSVariableStatusItemLength).init
    @status_item.setMenu(@status_menu)
    @status_item.setHighlightMode(true)
    @status_item.setTitle('...')

    @defaults = NSUserDefaults.standardUserDefaults
    @defaults['currency'] ||= 'BTC'

    @btc = createMenuItem('DOGE/BTC', 'toBtc')
    @btc.setState NSOnState if @defaults['currency'] == 'BTC'
    @status_menu.addItem @btc

    @usd = createMenuItem('DOGE/USD', 'toUsd')
    @usd.setState NSOnState if @defaults['currency'] == 'USD'
    @status_menu.addItem @usd

    @status_menu.addItem createMenuItem('Donations Appreciated', 'donations')
    @status_menu.addItem createMenuItem('Quit', 'terminate:')

    NSTimer.scheduledTimerWithTimeInterval(INTERVAL, target: self, selector: 'checkValue', userInfo: nil, repeats: true)
    self.checkValue
  end

  def createMenuItem(name, action)
    NSMenuItem.alloc.initWithTitle(name, action: action, keyEquivalent: '')
  end

  def donations
    alert = NSAlert.alloc.init
    alert.setMessageText "I'd greatly appreciate any donations."
    alert.setInformativeText 'DTWDpERzs3ihWCPesZDBsqovGUS9fNn4tA'
    alert.addButtonWithTitle 'OK'
    alert.runModal
  end

  def checkValue
    Dogecoin.send("to#{@defaults['currency'].capitalize}") do |price|
      @status_item.setTitle("Ð #{price}")
    end
  end

  def toBtc
    @status_item.setTitle('...')

    @btc.setState NSOnState
    @usd.setState NSOffState

    @defaults['currency'] = 'BTC'
    self.checkValue
  end

  def toUsd
    @status_item.setTitle('...')

    @btc.setState NSOffState
    @usd.setState NSOnState

    @defaults['currency'] = 'USD'
    self.checkValue
  end
end
