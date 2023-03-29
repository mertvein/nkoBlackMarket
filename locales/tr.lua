local Translations = {
    cfg = {
        targetLabel = 'Görüşme Yap'
    },

    menu = {
        header = 'Yasadışı Mal Kaçakçılığı',

        orderHeader = 'Sipariş Et',
        orderTxt = 'Sipariş oluşturarak bir şeye sahip olabilirsiniz..',

        finalHeader = 'Siparişleri Görüntüle',
        finalTxt = 'Siparişlerinizin size ulaşmasının ne kadar sürdüğünü kontrol edin',

        notify = 'Bizi yakalatmaya mı çalışıyorsun, kaybol!'
    },

    shop = {
        header = 'Eşya Listesi',
        txt = 'Çok fazla ürün var, size uygun olanı seçin',
        price = 'karşılığında satın al'
    },

    shipment = {
        header = 'Sipariş Edilen Eşyalar',
        txt = 'Ürüne göre süre değişebilir.',

        timeTxt = 'saniye kaldı.',
        takeTxt = 'Siparişinizi kontrol edin, gelmiş olabilir'
    },

    server = {
        order = ' siparişini teslim aldın.',
        war = 'Sevkiyat yandı, kaybol!',
        pay = 'Ödemeni yaptın ve sipariş verdin',
        noMoney = 'Cebindeki bir kuruşla benden bir şey almayı mı düşündün, sefil!'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})