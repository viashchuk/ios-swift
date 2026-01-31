import { DataTypes } from 'sequelize'
import sequelize from '../config/database.js'
import Order from './Order.js'
import User from './User.js'

const Payment = sequelize.define('Payment', {
    orderId: {
        type: DataTypes.INTEGER,
        allowNull: false,
        unique: false,
        references: {
            model: Order,
            key: 'id'
        }
    },
    userId: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
            model: User,
            key: 'id'
        }
    },
    amount: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false,
    },
    currency: {
        type: DataTypes.STRING,
        allowNull: false,
        defaultValue: 'USD'
    },
    status: {
        type: DataTypes.STRING,
        allowNull: false,
        validate: {
            isIn: [['pending', 'succeeded', 'failed', 'refunded']]
        }
    },
    cardLast4: {
        type: DataTypes.STRING(4),
        allowNull: true,
    },
    stripePaymentIntentId: {
        type: DataTypes.STRING,
        allowNull: true,
    }
}, {
    tableName: 'payments'
});

Payment.belongsTo(Order, { foreignKey: 'orderId', as: 'order' })
Order.hasOne(Payment, { foreignKey: 'orderId', as: 'payment' })

Payment.belongsTo(User, { foreignKey: 'userId', as: 'user' })
User.hasMany(Payment, { foreignKey: 'userId', as: 'payments' })

export default Payment