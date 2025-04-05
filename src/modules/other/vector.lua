local vector = {}

function vector.newVector(vectorX, vectorY)
    return {x = vectorX, y = vectorY}
end

function vector.multiplyVector(vector1, vector2)
    return {
        x = vector1.x * vector2.x,
        y = vector1.y * vector2.y
    }
end

function vector.multiplyVectorWithNumber(vector, number)
    return {
        x = vector.x * number,
        y = vector.y * number
    }
end

function vector.printVector(vector)
    print("x: " .. vector.x .. " y: " .. vector.y)
end

return vector