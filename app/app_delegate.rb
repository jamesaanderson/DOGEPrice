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

    @status_menu.addItem createMenuItem('Donations Appreciated', 'donations')
    @status_menu.addItem createMenuItem('Quit', 'terminate:')
    
    self.checkPrice
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

  def checkPrice
    Dogecoin.toBtc do |price|
      @status_item.setTitle("Ð #{price}")
    end

    NSTimer.scheduledTimerWithTimeInterval(INTERVAL, target: self, selector: 'checkPrice', userInfo: nil, repeats: true)
  end
end
