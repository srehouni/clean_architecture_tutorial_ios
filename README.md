# Casos de uso

##  Mostrar lista de cryptomonedas globales
 
Como usuario, quiero poder consultar las crypto globales ordenadas por capitalización de mercado (Market cap)

GIVEN Tengo la app iniciada
WHEN accedo a la vista de global
THEN veo un listado de las crypto globales
AND información básica de cada crypto (nombre, symbol, precio, cambio de precio últimas 24h, volumen últimas 24h, capitalización de mercado)
    
- Entities
    Cryptorcurrency
        Id
        Name
        Symbol
        Price
        Price24h
        Volume24h
        MarketCap
        
- Use cases
    Get Global Crypto List 
        

##  Ver historial de precios de una cryptomoneda

Como usuario, quiero poder consultar el historial del precio de una crypto
GIVEN Estoy en la vista de global
WHEN accedo al detalle de una cryptomoneda
THEN veo la información básica (nombre, symbol, precio, cambio de precio últimas 24h, volumen últimas 24h, capitalización de mercado)

GIVEN Estoy en la vista detalle de una cryptomoneda
WHEN selecciono el rango de días del histórico de precios (30 días, 90 días, 180 días y 1 año)
THEN veo el historial de precios para ese rango de días (30 días, 90 días, 180 días y 1 año) con precio y fecha

- Entities
    Cryptorcurrency
        Id
        Name
        Symbol
        Price
        Price24h
        Volume24h
        MarketCap
        
    CryptocurrencyPriceHistory
        Prices
     
     DataPoint
        Price
        Date
        
- Use cases
    Get Price History
