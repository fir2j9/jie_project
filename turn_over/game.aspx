<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="game.aspx.vb" Inherits="turn_over.game" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>翻转游戏</title>
    <style>
    .card {
      width: 100px;
      height: 100px;
      background-color: blue;
      margin: 5px;
      display: inline-block;
      cursor: pointer;
    }

    .flipped {
      background-color: red;
    }
  </style>
</head>
<body>
    <form id="form1" runat="server">
         <h1>翻转游戏</h1>
      <div id="game-board">
        <!-- 游戏板生成的卡片将动态添加 -->
      </div>

        <script>
            let level = 4; // 初始关卡等级

            // 创建游戏板
            function createGameBoard() {
                const gameBoard = document.getElementById('game-board');
                gameBoard.innerHTML = ''; // 清空游戏板

                const numCards = level * level;

                for (let i = 0; i < numCards; i++) {
                    const card = document.createElement('div');
                    card.className = 'card';
                    gameBoard.appendChild(card);
                }

                // 设置游戏板的宽度，使卡片呈现为四行四列的形式
                const cardWidth = 100;
                const cardMargin = 5;
                const boardWidth = (cardWidth + cardMargin * 2) * level;
                gameBoard.style.width = `${boardWidth}px`;


                // 重新绑定点击事件监听器
                bindCardClickListeners();
            }

            // 获取游戏板上的所有卡片
            function getAllCards() {
                return document.querySelectorAll('.card');
            }

            // 获取卡片的索引位置
            function getCardIndex(card) {
                const cards = getAllCards();
                return Array.from(cards).indexOf(card);
            }

            // 判断两个卡片是否为相邻的卡片
            function areCardsAdjacent(card1, card2) {
                const index1 = getCardIndex(card1);
                const index2 = getCardIndex(card2);

                const row1 = Math.floor(index1 / level);
                const col1 = index1 % level;
                const row2 = Math.floor(index2 / level);
                const col2 = index2 % level;

                return (
                    Math.abs(row1 - row2) + Math.abs(col1 - col2) === 1
                );
            }

            // 翻转相邻的卡片
            function flipAdjacentCards(card) {
                const cards = getAllCards();

                cards.forEach(otherCard => {
                    if (card !== otherCard && areCardsAdjacent(card, otherCard)) {
                        otherCard.classList.toggle('flipped');
                    }
                });
            }

            // 绑定卡片的点击事件监听器
            function bindCardClickListeners() {
                const cards = getAllCards();

                cards.forEach(card => {
                    card.addEventListener('click', () => {
                        // 切换卡片的翻转状态
                        card.classList.toggle('flipped');

                        // 翻转相邻的卡片
                        flipAdjacentCards(card);

                        // 检查是否所有卡片都翻转
                        const allFlipped = Array.from(cards).every(card => card.classList.contains('flipped'));
                        if (allFlipped) {
                            // 显示胜利消息
                            alert('你赢了！');

                            // 进入下一关
                            level++;
                            createGameBoard();
                        }
                    });
                });
            }

            // 初始化游戏板
            createGameBoard();
        </script>
        
    </form>
</body>
</html>
