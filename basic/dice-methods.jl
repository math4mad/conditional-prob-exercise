"""
    make_dice_space(n::Int)

输入骰子的数量,返回全概率空间数组

使用 `Iterators.product(fill(dice,n)...)`
动态生成有`n`个骰子的全概率空间
"""
function  make_dice_space(n::Int)

    dice=Vector(1:6)
    collect(Iterators.product(fill(dice,n)...))|>vec

end

"""
    make_emoji_dice_space(arr::Vector{Vector{Int64}})::Vector{Vector{String}}

根据全空间数组生成对应的 emoji 表示方法

需要动态生成,所以嵌套稍微复杂
"""
function make_emoji_dice_space(arr::Vector)::Vector{Vector{String}}
    emoji_dice=["1️⃣","2️⃣","3️⃣","4️⃣","5️⃣","6️⃣"]
    emoji_arr=[]
    #[[emoji_dice[d[1]],emoji_dice[d[2]]] for d in arr]
    for i in arr
        sub_arr=String[]
        for j in i
          push!(sub_arr,emoji_dice[j])
        end
        push!(emoji_arr,sub_arr)
    end
    return emoji_arr
end
#make_dice_space(3)|>make_emoji_dice_space|>length



two_dice_space= make_dice_space(2)
two_dice_size=length(two_dice_space)

three_dice_space= make_dice_space(3)
three_dice_size=length(three_dice_space)


#   定义question struct

   """
   DiceQuesiton
   
   Dice  条件概率 Struct

    - quesiton :问题

    - cond: 筛选条件

    - space : 全概率空间
    - space_size: 全概率孔家的大小
   """
    struct DiceQuesiton
    question::String   # eg  # 三个骰子点数都等于6
    cond::Function # 过滤方法:cond2(arr::Array)=arr[1]==6&&arr[2]==6&&arr[3]==6
    space::Array   # 全概率空间
    space_size::Int # 全概率空间 size
    end

## define  method get probability

"""
    answer_dice_problem(params::DiceQuesiton;show_dice=false)

根据问题构建筛选条件,返回条件概率
"""
function answer_dice_problem(params::DiceQuesiton;show_dice=false)
    (;question,cond,space,space_size)=params
    res=filter(cond,space)
    show_dice&&show(question=>make_emoji_dice_space(res))
    println("\n")
    show("$(question):概率"=>length(res)//space_size)
end
