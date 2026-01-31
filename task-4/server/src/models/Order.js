import { DataTypes } from 'sequelize'
import sequelize from '../config/database.js'
import User from './User.js'

const Order = sequelize.define('Order', {
    userId: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
            model: User,
            key: 'id'
        }
    },
    status: {
        type: DataTypes.STRING,
        allowNull: false,
        defaultValue: 'initialized',
        validate: {
            isIn: [['initialized', 'processing', 'completed', 'cancelled']]
        }
    },
    totalAmount: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false,
        defaultValue: 0.00
    },
    paymentMethod: {
        type: DataTypes.STRING,
        allowNull: false,
        validate: {
            isIn: [['card', 'cash', 'apple_pay', 'google_pay']]
        }
    }
},
    {
        tableName: 'orders'
    })

Order.belongsTo(User, { foreignKey: 'userId', as: 'user' });
User.hasMany(Order, { foreignKey: 'userId', as: 'orders' });

export default Order