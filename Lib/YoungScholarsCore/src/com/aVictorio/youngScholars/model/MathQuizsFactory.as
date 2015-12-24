package com.aVictorio.youngScholars.model
{
	import com.aVictorio.youngScholars.vos.GameDescriptor;
	import com.aVictorio.youngScholars.vos.MathQuestion;
	
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	public class MathQuizsFactory
	{
		private static var _instance:MathQuizsFactory;
		
		private var resourceManager:IResourceManager = ResourceManager.getInstance();
		
		public var mathGameSet:Array = [
			new GameDescriptor(MathQuestion.ADDITION_UNDER10, ""),
			new GameDescriptor(MathQuestion.ADDITION_BY2, ""),
			new GameDescriptor(MathQuestion.ADDITION_UNDER20, ""),
			new GameDescriptor(MathQuestion.ADDITION_BY5, ""),
			new GameDescriptor(MathQuestion.ADDITION_BY10, ""),
			new GameDescriptor(MathQuestion.ADDITION_BY3, ""),
			new GameDescriptor(MathQuestion.ADDITION_UNDER100, ""),
			new GameDescriptor(MathQuestion.DEDUCTION_UNDER10, ""),
			new GameDescriptor(MathQuestion.DEDUCTION_BY1, ""),
			new GameDescriptor(MathQuestion.DEDUCTION_BY2, ""),
			new GameDescriptor(MathQuestion.DEDUCTION_UNDER20, ""),
			new GameDescriptor(MathQuestion.DEDUCTION_BY5, ""),
			new GameDescriptor(MathQuestion.DEDUCTION_BY10, ""),
			//new GameDescriptor(MathQuestion.DEDUCTION_BY3, ""),
			new GameDescriptor(MathQuestion.DEDUCTION_UNDER100, ""),
			new GameDescriptor(MathQuestion.MULTIPLICATION_UNDER10, ""),
			new GameDescriptor(MathQuestion.MULTIPLICATION_BY1, ""),
			new GameDescriptor(MathQuestion.MULTIPLICATION_BY2, ""),
			new GameDescriptor(MathQuestion.MULTIPLICATION_BY3, ""),
			new GameDescriptor(MathQuestion.MULTIPLICATION_BY4, ""),
			new GameDescriptor(MathQuestion.MULTIPLICATION_BY5, ""),
			new GameDescriptor(MathQuestion.MULTIPLICATION_BY6, ""),
			new GameDescriptor(MathQuestion.MULTIPLICATION_BY7, ""),
			new GameDescriptor(MathQuestion.MULTIPLICATION_BY8, ""),
			new GameDescriptor(MathQuestion.MULTIPLICATION_BY9, ""),
			new GameDescriptor(MathQuestion.MULTIPLICATION_BY10, ""),
			new GameDescriptor(MathQuestion.MULTIPLICATION_UNDER20, ""),
			new GameDescriptor(MathQuestion.MULTIPLICATION_UNDER100, ""),
			new GameDescriptor(MathQuestion.DIVISION_UNDER10, ""),
			new GameDescriptor(MathQuestion.DIVISION_BY2, ""),
			new GameDescriptor(MathQuestion.DIVISION_UNDER20, ""),
//			new GameDescriptor(MathQuestion.DIVISION_BY5, ""),
//			new GameDescriptor(MathQuestion.DIVISION_BY10, ""),
//			new GameDescriptor(MathQuestion.DIVISION_BY3, ""),
			new GameDescriptor(MathQuestion.DIVISION_UNDER100, "")
		];

		protected var _quizType:String;


		public static function get instance():MathQuizsFactory
		{
			if (_instance == null)
				_instance = new MathQuizsFactory();
			return _instance;
		}
		
		public function MathQuizsFactory()
		{
		}
		
		public function loadResources():void
		{
			var index:int=0;
			for each (var game:GameDescriptor in mathGameSet)
			{
				game.label = resourceManager.getString("resource", game.gameType+"Title");
				game.gameIndex = index;
				index++;
			}			
		}
		
		public function getQuestion(quizType:String, lastAnswer:int):MathQuestion
		{
			var mathQuestion:MathQuestion = new MathQuestion();
			mathQuestion.quizType = quizType;
			mathQuestion.generateQuestion(lastAnswer);
			return mathQuestion;
		}
	}
}