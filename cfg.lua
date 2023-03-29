Config = {}

Config.Chance = 1 -- Chance of the item you ordered to be attacked by pirates during transport 0-50
Config.MinimumTime = 2 -- To access, it must be x o'clock at the earliest.
Config.MaximumTime = 5 -- You can reach up to x at the latest.
Config.PaymentType = 'cash' -- At the time of purchase, you can set the option to pay.
Config.DeliveryTime = 15 -- Delivery time of the ordered item.

Config.Seller = { -- You can duplicates NPCs from here
    {
        coords = vector4(338.4, 224.42, 127.76, 162.09),
        pedhash = 'a_m_m_hasjew_01',
        scenario = 'WORLD_HUMAN_COP_IDLES',
        targetLabel = Lang:t('cfg.targetLabel'),
        targetIcon = 'fas fa-people-carry'
    }
}

Config.Items = {
    {
        hash = 'weapon_knuckle',
        label = 'Knuckle',
        price = 1000,
        icon = 'fas fa-hands', -- You can edit the option icon in the menu here.
    },
    {
        hash = 'weapon_nightstick',
        label = 'Nightstick',
        price = 800,
        icon = 'fas fa-magic', -- You can edit the option icon in the menu here.
    },
    {
        hash = 'weapon_glock',
        label = 'Glock 18',
        price = 5000,
        icon = 'fas fa-gun', -- You can edit the option icon in the menu here.
    }
}