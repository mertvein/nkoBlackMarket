local Translations = {
    cfg = {
        targetLabel = 'Make an Deal'
    },

    menu = {
        header = 'Illegal Goods Smuggling',

        orderHeader = 'Order',
        orderTxt = 'You can own something by creating an order',

        finalHeader = 'Review Order',
        finalTxt = 'Check out how long it takes for your orders to arrive',

        notify = 'Are you trying to catch us, get lost!'
    },

    shop = {
        header = 'Tool List',
        txt = 'There are a lot of items, choose the one that suits you',
        price = 'order in return'
    },

    shipment = {
        header = 'Ordered Items',
        txt = 'Times may vary depending on the item.',

        timeTxt = 'seconds left.',
        takeTxt = 'Check your order, it may have arrived'
    },

    server = {
        order = ' you have received.',
        war = 'The shipment was burned, get lost!',
        pay = 'You have successfully paid and ordered.',
        noMoney = 'Did you think to buy something from me with a dime in your pocket, miserable!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})