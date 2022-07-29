// fixes all casing issues
module.exports = (rows) => {
        return rows.map( r => {
        const replacedKeys = {}
        for (let key in r) {
            const camelCase = key.replace(/([-_][a-z])/gi, ($1) => 
                $1.toUpperCase().replace('_', '')
            )
            replacedKeys[camelCase] = r[key]
        }
        return replacedKeys
    })
    
}