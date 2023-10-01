

"定义袋子类型"
struct Bag
    red::Int
    blue::Int
    green::Int
end

"""
枚举限定球种类
@ref:snippetslab://snippet/6016DF64-9B90-420E-83F7-7C6FF7D4A139
"""
@enum Ball red = 1 blue = 2 green = 3



"""
    new_bag_space_prob(bag::Bag, pick::Ball=red)::Tuple{Bag,Real}

从 bag 中取出 pick球以后, 返回取出该球的概率和取出该球之后的概率空间
    
```
        (; red, blue, green) = bag # struct 解构
        ball = Int(pick) # @enum 类型需要转换为整型
        prob_size = +(red, blue, green)  # 合计球总数
        res::Tuple{Bag,Real}=(Bag([red - 1, blue, green]...), red // prob_size)
```

如果取出的球为红色,定义新的(Bag([red - 1, blue, green]...) eg.
"""
function new_bag_space_prob(bag::Bag, pick::Ball=red)::Tuple{Bag,Real}
    (; red, blue, green) = bag # struct 解构
    ball = Int(pick) # @enum 类型需要转换为整型
    prob_size = +(red, blue, green)  # 合计球总数
    res::Tuple{Bag,Real} = if ball == 1
        (Bag([red - 1, blue, green]...), red // prob_size)
    elseif ball == 2
        (Bag([red, blue - 1, green]...), blue // prob_size)
    else
        (Bag([red, blue, green - 1]...), green // prob_size)
    end
    return res
end


bag = Bag(15, 18, 10)

res1 = new_bag_space_prob(bag, red)
res2 = new_bag_space_prob(res1[1], red)
both_red_ball=res1[2] * res2[2]

"取出两个红球的概率"=>both_red_ball

