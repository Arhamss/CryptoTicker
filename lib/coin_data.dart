// const url = 'https://rest.coinapi.io/v1/exchangerate/';
// const apiKey = 'D188064F-9282-4CB6-B622-DBE31CCA3034';
const url = 'https://api.exchangerate.host/latest?base=USD';
//https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=b602345d-f3ba-49be-9aad-51e7d881758a

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PKR',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const Map<String, String> cryptoListWithAbbreviation = {
  'AUR': 'Auroracoin',
  'BCH': 'Bitcoin Cash',
  'BTC': 'Bitcoin',
  'DASH': 'Dash',
  'DOGE': 'Dogecoin',
  'EOS': 'EOS.IO',
  'ETC': 'Ethereum Classic',
  'ETH': 'Ethereum',
  'GRC': 'Gridcoin',
  'LTC': 'Litecoin',
  'MZC': 'Mazacoin',
  'Nano': 'Nano',
  'NEO': 'Neo',
  'NMC': 'Namecoin',
  'Nxt': 'NXT',
  'POT': 'PotCoin',
  'PPC': 'Peercoin',
  'TIT': 'Titcoin',
  'USDC': 'USD Coin',
  'USDT': 'Tether',
  'VTC': 'Vertcoin',
  'XEM': 'NEM',
  'XLM': 'Stellar',
  'XMR': 'Monero',
  'XPM': 'Primecoin',
  'XRP': 'Ripple',
  'XVG': 'Verge',
  'ZEC': 'Zcash'
};
