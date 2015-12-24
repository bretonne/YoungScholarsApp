package com.aVictorio.youngScholars.views.games.quiz
{
	import com.aVictorio.youngScholars.model.GameModel;
	import com.aVictorio.youngScholars.model.MathQuizsFactory;
	import com.aVictorio.youngScholars.vos.GameDescriptor;
	import com.aVictorio.youngScholars.vos.MathQuestion;
	import com.renaun.mxml.QContainer;
	
	import flash.events.Event;
	
	import mx.effects.Fade;
	
	public class MathQuizBoard extends QContainer
	{
		[Bindable]
		public var question:MathQuestion;
		
		protected var _currentGame:GameDescriptor;
		protected var _dataChanged:Boolean = false;
		
		protected var mathModel:MathQuizsFactory = MathQuizsFactory.instance;
		
		[Bindable]
		protected var numOfCorrectAnswers:int=0;
		
		[Bindable]
		protected var numOfWrongAnswers:int=0;

		[Bindable]
		public function get currentGame():GameDescriptor
		{
			return _currentGame;
		}
		
		public function set currentGame(value:GameDescriptor):void
		{
			_currentGame = value;
			_dataChanged = true;
			invalidate();
		}
		
		public function MathQuizBoard(s:Number=100, su:String="percent")
		{
			super(s, su);
		}
		
		
		protected function loadQuestion(bNewQuiz:Boolean):void
		{
			var lastAnswer:int = -1;
			if (bNewQuiz == false)
			{
				if (question)
					lastAnswer = question.correctAnswer;
			}
			
			question = mathModel.getQuestion(currentGame.gameType, lastAnswer);
		}
		

		
		protected function onAnswerClicked(index:int):void
		{
			var answer:int = question.answers[index];
			if (answer == question.correctAnswer)
				numOfCorrectAnswers++;
			else
				numOfWrongAnswers++;
			
			if ((numOfCorrectAnswers + numOfWrongAnswers) < question.NumberOfQuestions)
			{
				loadQuestion(false);
				dispatchEvent(new Event("nextQuestion", true, true));
			}
			else
			{//end the game
				dispatchEvent(new Event("gameOver", true, true));
			}
		}
		
	}
}