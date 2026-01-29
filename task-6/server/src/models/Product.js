import { DataTypes } from 'sequelize'
import sequelize from '../config/database.js'
import Category from './Category.js'

const Product = sequelize.define('Product', {
    name: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    description: {
        type: DataTypes.TEXT,
    },
    price: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false,
    },
    categoryId: {
        type: DataTypes.STRING,
        allowNull: false,
        references: {
            model: Category,
            key: 'id'
        }
    },
    imageUrl: {
        type: DataTypes.STRING,
    },
},
    {
        tableName: 'products'
    })

Product.belongsTo(Category, { foreignKey: 'categoryId', as: 'category' })
Category.hasMany(Product, { foreignKey: 'categoryId', as: 'products' })

export default Product